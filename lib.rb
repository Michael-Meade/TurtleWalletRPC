require 'excon'
require 'json'
class ReadConfig
    def initialize(config = nil)
        if config.nil?
            config = File.join("data", "config.json")
        end
        @config = config
    end
    def config
        read = @config
        JSON.parse(File.read(read))
    end
end
class HTTP < ReadConfig
    def initialize
        @ip    = ReadConfig.new.config["ip"]
        @dHost = ReadConfig.new.config["daemonHost"]
        @dPort = ReadConfig.new.config["daemonPort"]
        @fn    = ReadConfig.new.config["filename"]
        @pass  = ReadConfig.new.config["password"]
        @key   = ReadConfig.new.config["X-API-KEY"]
    end
    def ip
        @ip
    end
    def dhost
        @dHost
    end
    def dport
        @dPort
    end
    def filename
        @fn
    end
    def pass
        @pass
    end
    def key
        @key
    end
    def post(meth, j = nil)
        l = Excon.post(File.join(ip,meth), :debug_request => true, :debug_response => true, :body => j,  :headers => {
            'accept'       => "application/json",
            'X-API-KEY'    => key
        }).body
    end
    def get(meth)
        l = Excon.get(File.join(ip, meth), :headers => {'accept'       => "application/json",  'X-API-KEY'    => key, 'X=Content-Type' => 'application/json'}).body
    JSON.parse(l)
    end
    def put(meth, new_port, new_ip)
        l = Excon.put(File.join(ip, meth), :body => "daemonHost=#{new_ip}&daemonPort=#{new_port}&password=#{pass}", :headers => {'accept'       => "application/json",  'X-API-KEY'    => key,}).body
    JSON.parse(l)
    end
end
class Helper < HTTP
    def json(j)
        out_json = "daemonHost=#{dhost}&daemonPort=#{dport}&filename=#{filename}&password=#{pass}&"
        j.each do |keys, value|
            out_json += "#{keys}=#{value}&"
        end
    out_json
    end
end
class Wallet < HTTP
    H = Helper.new
    def open_wallet 
        post("/wallet/open")
    end
    def create_addresses
        post('/addresses/create')
    end
    def list_addresses
        # Gets a list of all the addresses in the wallet container
        get('/addresses')
    end
    def wallet_addresses_import_view(public_spend_key, scan_height = 300000)
        # Imports a view only subwallet with the given publicSpendKey
        post('/addresses/import/view', { "scanHeight": scan_height, "publicSpendKey": public_spend_key })
    end
    def wallet_addresses_import(private_spend_key, scan_height = 300000)
        # Imports a subwallet with the given private spend key
        # scan_height is set as '300000' by default.
        post('addresses/import', { "scanHeight": scan_height, "privateSpendKey": "#{private_spend_key}"}.to_json)
    end
    def node
        # Get the nodes address, port, fee and fee address
        get('/node')
    end
    def save
        # Save the wallet state
        put('/save')
    end
    def balance
        # Get the balance for the entire wallet container
        get('/balance')
    end
    def balance_address(addr)
        # Get the balance for a specific address
        get("/balance/#{addr}")
    end
    def balances
        get('/balances')
    end
    def address_primary
        # gets the primary address
        get('/addresses/primary')
    end
    def set_node(port, ip)
        # Sets the node address & port
        put('/node', port, ip)
    end
    def status
        get('/status')
    end
    def keys_address(addr)
        # Gets the public & private spend key for a given address.
        # Note: it cant be used with a view only wallet
        get("/keys/#{addr}")
    end
    def keys
        # Gets the wallet containers shared private view key
        get('/keys')
    end
    def keys_mnemonic(addr)
        # Gets the mnemonic seed for the given address. 
        # NOTE: can't be used with only a view only wallet.
        get("/keys/mnemonic/#{addr}")
    end

    def wallet_import_view(private_view_key, addr, scan_height = 300000)
        j = H.json({ "scanHeight": scan_height, "privateViewKey": private_view_key, "address": addr})
        # Imports a view only wallet with a private view key and public address. 
        post('/wallet/import/view',  j )
    end
    def export_json(filename)
        j = { "filename" => filename }
        post('/export/json', j.to_json )
    end
    def transactions_unconfirmed_addr(addr)
        # Gets a list of all unconfirmed, outgoing transactions in the wallet container
        # Note that this DOES NOT include incoming transactions in the pool.
        # This only applies to transactions that have been sent by this wallet file, and have not been added to a block yet.
        get("/transactions/unconfirmed/#{addr}")
    end
    def transactions_unconfirmed
        # Gets a list of all unconfirmed, outgoing transactions in the wallet container
        get('/transactions/unconfirmed')
    end
    def transactions
        # Gets a list of all transactions in the wallet container
        get('/transactions')
    end

end

#Wallet.new.set_node
#Wallet.new.list_addresses
#Wallet.new.addresses_import("5c703d9bde0b7cd5ff3e19ea826a44066534661a7322c85e854e73f06e49cd06")
#Wallet.new.open_wallet
#ReadConfig.new.get_address
#Wallet.new.keys_mnemonic("TRTLuxL46JJa4bTYMyQGLi4euHoe3QUNQQ5niiPoYah15pc6ESFdZJ59KmtDUzedHASfDRYPxVbEpYQsXUtBmQRL18pDdK72F5i")
#Wallet.new.balance("TRTLv2TUfhPjk4ZGfCG65QKFkkabStMKY4esTV8iKfdrZza11nt8D659KmtDUzedHASfDRYPxVbEpYQsXUtBmQRL18pDdMacALV")
#t = Wallet.new
#puts t.create_addresses

#t.wallet_import_view("9b40ced5414a943cb06427c83730d4a3c38d98cceff4dc1a16c631f0697c141a", 300000)

