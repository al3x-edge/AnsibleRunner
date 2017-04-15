require 'tempfile'
require 'yaml'
require 'open3'

module AnsibleRunner
  class Core
    attr_reader :inventory_file

    def initialize(hosts=[], playbook_path)
      raise ArgumentError unless hosts.all? { |h| h.is_a? String }

      @playbook_path ||= playbook_path

      generate_inventory_file hosts
      validate_playbook_yaml
    end

    def run
      Open3.popen3(ansible_command)
    end

    private
    def generate_inventory_file(hosts)
      temp_inventory = Tempfile.new('inventory')
      temp_inventory.puts hosts
      temp_inventory.close
      @inventory_file = temp_inventory
    end

    def playbook_data
      path = Pathname.new(@playbook_path).cleanpath
      @playbook_file ||= File.read(path)
    end

    def validate_playbook_yaml
      begin
        Psych.load playbook_data
      rescue Psych::SyntaxError
        raise Errors::YamlSyntaxError
      end
    end

    def ansible_command
      "ansible-playbook -i #{@inventory_file.path} #{@playbook_path}"
    end
  end

  class Errors
    YamlSyntaxError = Class.new(StandardError)
  end
end
