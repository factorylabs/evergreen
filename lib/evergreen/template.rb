module Evergreen
  class Template
    attr_reader :name, :suite

    def initialize(suite, name)
      @suite = suite
      @name = name
    end

    def name
      @name.gsub("/#{Evergreen.template_dir}/", '')
    end

    def root
      suite.root
    end

    def full_path
      File.join(root, @name)
    end

    def read
      File.read(full_path)
    end
    alias_method :contents, :read

    def escaped_contents
      contents.to_json.gsub("<script>", %{<scr" + "ipt>}).gsub("</script>", %{</scr" + "ipt>})
    end

    def exist?
      File.exist?(full_path)
    end

  end
end
