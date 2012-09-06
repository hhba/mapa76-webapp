require 'test_helper'

class RegisterTest < ActiveSupport::TestCase
  context "Register" do
    setup do
      name_entity = create :name_entity
      name_entity_1 = create :name_entity
      date_entity = create :date_entity
      where_entity = create :where_entity
      @document = create :document
      @register = create :register, document: @document,
                         who: [name_entity.id], what: "nacio",
                         when: [date_entity.id], where: [where_entity.id],
                         to_who: [name_entity_1.id]
    end

    should "export info as a hash" do
      assert_instance_of Hash, @register.to_hash
    end
  end
end
