module SequenceDiagram
  class Participant
    @@uid = 0

    attr_reader :name
    attr_reader :distance
    attr_reader :uid
    attr_reader :aliasing
    def initialize(name, aliasing, distance = nil, thread = false)
      @name = name
      @aliasing = aliasing
      @distance = distance
      @thread   = thread
      @uid = @@uid += 1
    end

    def to_s
      cmd = @thread ? "newthread" : "newinst"
      if @distance.nil?
        "\\#{cmd}{#@uid}{#{SequenceDiagram.latex_escape(@name)}}"
      else
        "\\#{cmd}[#@distance]{#@uid}{#{SequenceDiagram.latex_escape(@name)}}"
      end
    end

    def ==(other)
      @uid == other.uid
    end
  end
end
