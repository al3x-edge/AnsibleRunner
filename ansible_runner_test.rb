require_relative 'ansible_runner'
require "minitest/autorun"

describe 'AnsibleRunner' do
  before do
    @ar = AnsibleRunner.new ["localhost"]
  end

  it "must have access to a ansible-playbook executable" do
    # Not sure how to test this condition
  end

  it "creates temporary inventory file from hosts" do
    @ar.inventory_file.path.wont_equal ""
    inventory = File.read @ar.inventory_file.path
    inventory.must_equal "localhost\n"
  end

  it "handles multiple hosts by creating one per-line in the temporary file" do
    ar = AnsibleRunner.new ["localhost", "127.0.0.1"]
    ar.inventory_file.path.wont_equal ""
    inventory = File.read ar.inventory_file.path
    inventory.must_equal "localhost\n127.0.0.1\n"
  end

  it "only accepts array of string hostnames" do
    proc { AnsibleRunner.new [1, 2, 3] }.must_raise ArgumentError
  end

  it "validates yml syntax" do
    skip "Not Implemented"
  end

  it "runs the playbook across all hosts given" do
    skip "Not Implemented"
  end

  it "displays whether the play was successful or not in stdout" do
    skip "Not Implemented"
  end

  it "replays the Ansible command output to a logger" do
    skip "Not Implemented"
  end

  it "replays the Ansible command output to stdout if in verbose mode" do
    skip "Not Implemented"
  end
end
