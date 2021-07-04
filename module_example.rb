require_relative 'lib/TurtleCoin'
require 'securerandom'
require 'json'
require 'bigdecimal'
module TurtleCoin
    @w = Wallet.new
    def self.create_addresses(count=1)
        # default count is 1.
        for i in 1..count.to_i
            @w.create_addresses
        end
        nil
    end
    def self.close
        @w.wallet_close
    end
    def self.auto_on
        # If the wallet is off, it will open the wallet using the
        # log_on method
        j = JSON.parse(@w.status)
        if j.to_h.key?("error")
            puts "Starting wallet.."
            log_on
        end
    end
    def self.status
        # get status
        @w.status
    end
    def self.log_on(filename = @w.filename, password = @w.pass)
        # opens the wallet
        # defaults as the wallet suplied in the config
        @w.open_wallet(filename, password)
    end
    def self.get_balances
        # display the balances & addresses
        JSON.parse(@w.balances).each {|key, value| puts "Address: #{key["address"]}\nUnlocked: #{key["unlocked"]}\nLocked: #{key["locked"]}\n\n"}
    nil
    end
    def self.get_balances_array
        bal = []
        JSON.parse(@w.balances).each {|key, value| bal << [key["address"], key["unlocked"], key["locked"]]} 
    return bal
    end
    def self.get_addresses_array
        addresses = []
        JSON.parse(@w.list_addresses)["addresses"].each {|addr| addresses << addr }
     return addresses
    end
    def self.save_addresses
        addresses = get_addresses_array
        File.open(File.join("addresses.txt").to_s, 'a') { |file| file.write(addresses.join("\n") + "\n") }
    end
    def self.get_addresses
        # displays the addresses
        JSON.parse(@w.list_addresses)["addresses"].each {|addr| puts "Address: #{addr}"}
    nil
    end
    def self.keys
        JSON.parse(@w.keys)
    end
    def self.get_balance
        @w.balance
    end
    def self.address_count
        # get address count
        JSON.parse(@w.list_addresses)["addresses"].count
    end
    def self.all_addresses
        # list all addresses
        JSON.parse(@w.list_addresses)
    end
    def self.incoming_transcations(addr)
        @w.transactions_unconfirmed_addr(addr)
    end
    def self.create_integrated(addr, hex=nil)
        if hex.nil?
            # this will create an random 64 char hex string
            hex = SecureRandom.hex(32)
        end
        puts "HEX: " + hex
    JSON.parse(@w.create_integrated_address(addr, hex))
    end
    def self.save_keys(addr)
        j = @w.keys_address(addr).to_json
        File.open(File.join("#{addr}.txt").to_s, 'a') { |file| file.write(j) }
    end
    def self.node
        JSON.parse(@w.node)
    end
    def self.set_node(node_port = 11898, node = "TRTLnode.ddns.net")
        # store the results of '/node' - contains node info
        n = self.node
        if n["daemonHost"] == "127.0.0.1"
            @w.set_node(node_port, node)
        end
    end
    def self.create_new_wallet(wallet, pass, node_port = 11898, node = "TRTLnode.ddns.net")
        # This will close the current wallet
        @w.wallet_close
        # Create new wallet
        @w.create_wallet(wallet, pass)
        # we have conncet our wallet to a node
        @w.set_node(node_port, node)
    end
    def self.transactions_table
        out = []
        transactions["transactions"].each do |i|
            trans = i["transfers"].shift
            fee = i["fee"].to_i / 100
            out << [trans["address"], trans["amount"].to_i / 100, i["hash"], fee, i["timestamp"], i["paymentID"]]
        end
        nil
    return out
    end
    def self.transactions
        @w.transactions
    end
end
TurtleCoin.auto_on
TurtleCoin.set_node


