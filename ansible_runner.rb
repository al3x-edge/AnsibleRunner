require 'tempfile'

class AnsibleRunner
  attr_reader :inventory_file

  def initialize(hosts=[])
    raise ArgumentError unless hosts.all? { |h| h.is_a? String }

    generate_inventory_file hosts
  end

  private
  def generate_inventory_file(hosts)
    temp_inventory = Tempfile.new('inventory')
    temp_inventory.puts hosts
    temp_inventory.close
    @inventory_file = temp_inventory
  end
end
