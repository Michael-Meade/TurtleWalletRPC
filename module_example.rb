require_relative 'lib/TurtleCoin'
require 'securerandom'
require 'json'
require 'bigdecimal'
module TurtleCoin
    @w = Wallet.new
    def self.create_addresses(count=1)
        # default count is 1.
        array = []
        for i in 1..count.to_i
            array << JSON.parse(@w.create_addresses)
        end
    return array
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
    def self.primary_addr
        @w.address_primary.to_h["address"]
    end
    def self.keys
        JSON.parse(@w.keys)
    end
    def self.get_balance
        @w.balance
    end
    def self.private_key_transaction(hash)
        @w.transaction_private_key(hash)
    end
    def self.address_count
        # get address count
        JSON.parse(@w.list_addresses)["addresses"].count
    end
    def self.get_mnemonic(addr)
        @w.keys_mnemonic(addr)
    end
    def self.all_addresses
        # list all addresses
        JSON.parse(@w.list_addresses)
    end
    def self.import_mnemonic_seed(mnemonic_seed)
        # Imports a wallet using a mnemonic seed
        scan_height = JSON.parse(status)["walletBlockCount"]
        @w.import_seed(mnemonic_seed, scan_height)
    end
    def self.import_pub_spend(public_spend_key)
        # Imports a view only subwallet with the given publicSpendKey
        scan_height = JSON.parse(status)["walletBlockCount"]
    @w.wallet_addresses_import_view(public_spend_key, scan_height)
    end
    def self.import_private_spend(private_spend_key)
        # Imports a subwallet with the given private spend key
        # first it gets the wallet's block count.
        scan_height = JSON.parse(status)["walletBlockCount"]
    @w.wallet_addresses_import(private_spend_key, scan_height.to_i)
    end
        
    def self.save_keys
        all_addresses["addresses"].each do |addr|
           puts get_mnemonic(addr)["mnemonicSeed"]
        end
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
            fee   = i["fee"].to_i / 100
            out << [trans["address"], trans["amount"].to_i / 100, i["hash"], fee, i["timestamp"], i["paymentID"]]
        end
        nil
    return out
    end
    def self.transaction_info(hash)
        JSON.parse(@w.transaction_hash_info(hash))["transaction"]
    end
    def self.transactions
        @w.transactions
    end
end
TurtleCoin.auto_on
TurtleCoin.set_node

