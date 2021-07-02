require_relative 'module_example'
require 'colorize'
require 'terminal-table'
require 'io/console'




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

while true

    print("\n1] Node Info\n2] Balance\n3] Create integrated\n4] Create New Addr\n5] List Addresses\n")
    print("Enter cmd:\n")

    cmd = gets
    $stdout.clear_screen
    if cmd.to_i == 1
        user_table = Terminal::Table.new do |v|
          v.title = "Wallet Info"
          v.headings = 'Network Block Count', 'Peer Count', 'Local Daemon Block Count', 'Hash Rate', 'View Wallet', 'SubWallet #'
          v << [ j["networkBlockCount"].to_s.green, j["peerCount"].to_s.green, j["localDaemonBlockCount"].to_s.green, j["hashrate"].to_s.green, view_wallet_switch(j["isViewWallet"]), j["subWalletCount"].to_s.green]
          v.style = { :border_left => false, :border_right => false, :border => :unicode, :all_separators => true }
        end
    puts user_table
    n = TurtleCoin.node
    user_table = Terminal::Table.new do |v|
          v.title = "Node Info"
          v.headings = 'Daemon Host', 'Daemon Port', 'SSL', 'Node Fee', 'Node Address'
          v << [ n["daemonHost"].to_s.green, n["daemonPort"].to_s.green, n["daemonSSL"].to_s.green, n["nodeFee"].to_s.green, n["nodeAddress"]]
          v.style = { :border_left => false, :border_right => false, :border => :unicode, :all_separators => true }
        end
    puts user_table
    elsif cmd.to_i == 2
        l = TurtleCoin.get_balances_array
        p l
        user_table = Terminal::Table.new do |v |
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
    elsif cmd.to_i == 4
        new_addr = TurtleCoin.create_addresses
        puts new_addr
    elsif cmd.to_i == 5
        i = 0
        TurtleCoin.all_addresses["addresses"].each do |a|
            if i.even?
                puts a.green
            else
                puts a.red
            end
            i+=1
        end
    end

end
