require "rspec"

require_relative "account"

describe Account do
  describe "#initialize" do

    it "requires one params" do
      expect { Account.new }.to raise_error(ArgumentError)
    end

    it "initializes with account-num and balance" do
      account = Account.new("1234567890", 100)
      account.should be_an_instance_of Account
    end  
  
    it "initializes with just balance" do
      account = Account.new("1234567890")
      account.should be_an_instance_of Account
    end
  end


  describe "#transactions" do

    context "default starting balance" do
      let(:account) { Account.new("1234567890")  }

        it " should return account balance of 0" do 
          account.transactions.first.should eq 0
        end

        it "has only one transaction" do 
          account.transactions.count.should eq 1
        end
    end
    
    context "starting balance other than default" do
      let(:account) { Account.new("1234567890", 100)  }

        it " should return account balance of 100" do 
          account.transactions.first.should eq 100
        end

        it "has only one transaction" do 
          account.transactions.count.should eq 1
        end
    end         
  end

  describe "#balance" do
    let(:account) { Account.new("1234567890", 100)  }

    it "increases the balance by 100 if 100 is deposited" do
      account.deposit!(100)
      account.balance.should eq 200
    end

    it "doesnt change the balance if 0 is deposited" do
      account.deposit!(0)
      account.balance.should eq 100
    end

    it "decreases the balance by -10 if 10 is withdrawn" do
      account.withdraw!(10)
      account.balance.should eq 90
    end

    it "doesnt change the balance if 0 is withdrawn" do
      account.withdraw!(0)
      account.balance.should eq 100
    end
  end

  describe "#account_number" do
    it "fails when 9 digits entered into account num" do 
      expect { Account.new("123456789") }.to raise_error(InvalidAccountNumberError)
    end

    it "fails when 11 digits entered into account num" do 
      expect { Account.new("12345678922") }.to raise_error(InvalidAccountNumberError)
    end

    it "fails when non-digits entered into account num" do 
      expect { Account.new("absgdyteur") }.to raise_error(InvalidAccountNumberError)
    end
  end


  describe "deposit!" do
 
   context "starting with a valid account to test deposits" do
     let(:account) { Account.new("1234567890", 100)  }

      it "successfully deposits amount > 0 to transactions" do
        account.deposit!(100)
        account.transactions.count.should eq 2
      end

      it "raises deposit error if the amount is < 0" do
        expect {account.deposit!(-90)}.to raise_error(NegativeDepositError)
      end
    end
  end

  describe "#withdraw!" do
    context "starting with a valid account to test withdrawls" do
     let(:account) { Account.new("1234567890", 100)  }

      it "successfully withdraw 50 if -50 is given" do
        account.withdraw!(-50)
        account.balance.should eq 50
      end

      it "successfully withdraw 50 if 50 is given" do
        account.withdraw!(50)
        account.balance.should eq 50
      end
    end
  end
end
