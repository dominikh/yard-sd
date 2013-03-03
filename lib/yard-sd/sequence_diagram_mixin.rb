require "digest/sha1"

module SequenceDiagramMixin
  def htmlify(*args)
    res = super
    res = res.gsub(/<pre class="[^"]+? sd"><code>(.+?)<\/code><\/pre>/m, "\\1")
    res
  end

  def html_syntax_highlight_sd(source)
    orig_source = source
    lines = source.split("\n")
    metadata = lines.take_while {|l| l.start_with?("%")}
    source   = lines[metadata.size..-1].join("\n")

    metadata_h = {}
    metadata.each do |line|
      if line =~ /^%\s*([^\s=]+)\s*=\s*(.+)$/
        key = $1.to_sym

        case key
        when  :size
          metadata_h[key] = $2
        end
      end
    end

    begin
      diagram = SequenceDiagram::Diagram.new.parse(source)
      img     = diagram.to_png(metadata_h)

      hash = Digest::SHA1.hexdigest(orig_source)
      name = "images/diagrams/#{hash}.png"
      options[:serializer].serialize(name, img)

      return "<img src='%s' alt='Sequence diagram' />" % url_for(options[:serializer].serialized_path(name))
    rescue SequenceDiagram::ParseError => e
      return "Error: Parsing error: #{h(e.inspect)}"
    rescue => e
      return "Error: #{h([e.message, e.backtrace].inspect)}"
    end
  end
end

YARD::Templates::Template.extra_includes << SequenceDiagramMixin
