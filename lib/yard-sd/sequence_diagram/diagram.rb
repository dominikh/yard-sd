require "tmpdir"
require "fileutils"

module SequenceDiagram

  class Diagram
    Call        = Struct.new(:p1, :p2, :message, :return)
    @@uid = 0

    attr_reader :uid
    def initialize
      @participants = []
      @calls        = []
      @uid          = @@uid += 1
    end

    def parse(s)
      last_calls = Hash.new {|h, k| h[k] = []}

      s.each_line do |line|
        line.chomp!
        next if line.empty?

        case line
        when /^(participant|thread)(?:\[(\d+)\])? ("?)(.+?)\3(?: as (.+))?$/
          distance = $2 && $2.to_i
          name = $4
          aliasing = $5 || name
          thread = $1 == "thread"
          @participants << Participant.new(name, aliasing, distance, thread)
        when /^(.+?)\s*(->|-->)\s*(.+?):(?: (.+))?$/
          p1      = @participants.find {|p| p.aliasing == $1}
          p2      = @participants.find {|p| p.aliasing == $3}

          error(:unknown_participant, line) if p1.nil?
          error(:unknown_participant, line) if p2.nil?

          message = $4

          case $2
          when "->"
            call = Call.new(p1, p2, message, nil)
            last_calls[p1] << call
            @calls << call
          when "-->"
            last_calls[p2].pop.return = message.to_s
            @calls << :pop
          end
        when /^noreturn$/
          @calls << :pop
        else
          error(:cannot_parse, line)
        end
      end

      self
    end

    def error(kind, information)
      raise ParseError, [kind, information].inspect
    end

    def to_s
      s = "\\begin{sequencediagram}\n"
      @participants.each do |p|
        s << p.to_s << "\n"
      end

      last_callee = nil
      open = []
      @calls.each do |call|
        if call == :pop
          # not nesting, close last call
          indent = " " * (open.size - 1) * 2
          s << indent << "\\end{#{open.pop}}\n"
          next
        end

        indent = " " * open.size * 2

        if !call.return.nil?
          if call.p1 == call.p2
            s << indent << "\\begin{callself}{#{call.p1.uid}}{#{SequenceDiagram.latex_escape(call.message)}}{#{SequenceDiagram.latex_escape(call.return)}}\n"
            open << :callself
          else
            s << indent << "\\begin{call}{#{call.p1.uid}}{#{SequenceDiagram.latex_escape(call.message)}}{#{call.p2.uid}}{#{SequenceDiagram.latex_escape(call.return)}}\n"
            open << :call
          end
        else
          s << indent << "\\begin{messcall}{#{call.p1.uid}}{#{SequenceDiagram.latex_escape(call.message)}}{#{call.p2.uid}}\n"
          open << :messcall
        end
      end

      while close = open.pop
        close = "\\end{#{close}}\n"
        indent = " " * open.size * 2
        s << indent << close
      end

      s << "\\end{sequencediagram}"
    end

    def to_png(options = {})
      graph    = self.to_s
      tex      = Template.sub("%%EMBED\n", graph.sub(/\n+$/, ""))
      dir      = Dir.mktmpdir
      image    = nil

      Dir.chdir(dir) do
        # File.open("/tmp/debug.tex", "w"){|f| f.print tex}
        IO.popen("pdflatex -halt-on-error", "w+") do |pipe|
          pipe.write tex
          pipe.close_write
          pipe.read
        end

        if $?.exitstatus != 0
          error("Couldn't compile latex", nil)
        end

        args = ["-depth", "4",
                "-quality", "95",
                "-colorspace", "RGB",
                "-density", "1000x1000",
                "-flatten"]

        args << "-resize" << options[:size] if options[:size]

        image = `convert #{args.join(" ")} texput.pdf png:-`
      end

      FileUtils.rm_rf(dir)

      return image
    end
  end
end
