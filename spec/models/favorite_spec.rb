require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'validations' do
    it {should belong_to :user}
    it {should belong_to :city}
  end
end
