require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is not valid when password and password_confirmation doesn\'t match' do
      @user = User.create(first_name:'Kenny', last_name:'Zhang', email:'zhang@gmail.com', password:'123', password_confirmation:'321')
      expect(@user).to_not be_valid
    end
    it 'is not valid when password is blank' do
      @user = User.create(first_name:'Kenny', last_name:'Zhang', email:'zhang@gmail.com', password:nil, password_confirmation:'321')
      expect(@user).to_not be_valid
    end
    it 'is not valid when password_confirmation is blank' do
      @user = User.create(first_name:'Kenny', last_name:'Zhang', email:'zhang@gmail.com', password:'123', password_confirmation:nil)
      expect(@user).to_not be_valid
    end
    it 'is not valid when first_name is blank' do
      @user = User.create(first_name:nil, last_name:'Zhang', email:'zhang@gmail.com', password:'123', password_confirmation:'123')
      expect(@user).to_not be_valid
    end
    it 'is not valid when last_name is blank' do
      @user = User.create(first_name:'Kenny', last_name:nil, email:'zhang@gmail.com', password:'123', password_confirmation:'123')
      expect(@user).to_not be_valid
    end
    it 'is not valid when email is blank' do
      @user = User.create(first_name:'Kenny', last_name:'zhang', email:nil, password:'123', password_confirmation:'123')
      expect(@user).to_not be_valid
    end
    it 'is not valid when email is not unique' do
      @user = User.create(first_name:'Kenny', last_name:'zhang', email:'siningtong@gmail.com', password:'123', password_confirmation:'123')
      @user1 = User.create(first_name:'Kenny', last_name:'Ghang', email:'siningtong@gmail.com', password:'123', password_confirmation:'123')
      expect(@user1.id).to be_nil
      # expect(@user1.errors.full_messages).to be_present
    end
    it 'is not valid when password length is less than 6' do
      @user = User.create(first_name:'Kenny', last_name:'zhang', email:'siningtong@gmail.com', password:'123', password_confirmation:'123')
      expect(@user.errors.full_messages).to be_present
    end
  end
  describe '.authenticate_with_credentials' do
    it 'should return an instance of user when email exists in the db' do
      @user = User.create(first_name:'q', last_name:'w', email:'qw@qwmail.com', password:'123456', password_confirmation:'123456')
      @user1 = User.authenticate_with_credentials('qw@qwmail.com','123456')
      expect(@user1).to have_attributes(:email => 'qw@qwmail.com')
    end
    it 'should be authenticated successfully if a visitor types in a few spaces before and/or after their email address' do
      @user = User.create(first_name:'q', last_name:'w', email:'qw@qwmail.com', password:'123456', password_confirmation:'123456')
      @user1 = User.authenticate_with_credentials('   qw@qwmail.com','123456')
      expect(@user1).to have_attributes(:email => 'qw@qwmail.com')
    end
    it 'should be authenticated successfully if a visitor types in a few spaces before and/or after their email address' do
      @user = User.create(first_name:'q', last_name:'w', email:'qw@qwmail.com', password:'123456', password_confirmation:'123456')
      @user1 = User.authenticate_with_credentials('QW@QWmail.com','123456')
      expect(@user1).to have_attributes(:email => 'qw@qwmail.com')
    end
  end
end