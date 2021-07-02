require_relative 'module_example'
require 'colorize'
require 'terminal-table'
require "rqrcode"



status = TurtleCoin.status

j = JSON.parse(status)


#TurtleCoin.save_addresses
def view_wallet_switch(wallet)
    if wallet 
        return "true".green
    else
        return "false".red
    end
end
p TurtleCoin.keys
while true
    print("\n1] Node Info\n2] Balance\n3] Create integrated\n")
    print("Enter cmd:\n")
    cmd = gets
    if cmd.to_i == 1
        user_table = Terminal::Table.new do |v|
          v.title = "Node Info"
          v.headings = 'Network Block Count', 'Peer Count', 'Local Daemon Block Count', 'Hash Rate', 'View Wallet', 'SubWallet #'
          v << [ j["networkBlockCount"].to_s.green, j["peerCount"].to_s.green, j["localDaemonBlockCount"].to_s.green, j["hashrate"].to_s.green, view_wallet_switch(j["isViewWallet"]), j["subWalletCount"].to_s.green]
          v.style = { :border_left => false, :border_right => false, :border => :unicode, :all_separators => true }
        end
    puts user_table
    elsif cmd.to_i == 2
        l = TurtleCoin.get_balances_array
        user_table = Terminal::Table.new do |v|
          v.title = "Balances"
          v.headings = 'Address', 'Unlocked', 'locked'
          v << [ l[0][0], l[0][1], l[0][2]]
          v.style = { :border_left => false, :border_right => false, :border => :unicode, :all_separators => true }
        end
    puts user_table
    elsif cmd.to_i == 3
        print("Enter address:")
        addr = gets.strip
        print("\n\n\n")
        puts "Address: " + TurtleCoin.create_integrated(addr)["integratedAddress"].green
    end
end
