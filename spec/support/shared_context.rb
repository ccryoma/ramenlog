RSpec.shared_context "setup" do

  let(:members) { create_list(:member, 40, :other_member) }
  let(:shops) { create_list(:shop, 40, :other_shop) }

end