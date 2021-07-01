require_relative 'module_example'
print("=========Wallet=========\n")
puts TurtleCoin.get_balances
print("=========Info=========\n")
print("Address Count: " + TurtleCoin.address_count.to_s)
print("\n")
print("Saving addresses in addresses.txt...\n")

status = TurtleCoin.status

j = JSON.parse(status)


print("\n=========Status=========\n")
print("Wallet Block Count: #{j["walletBlockCount"]}\n")
print("Local Daemon Block Count: #{j["localDaemonBlockCount"]}\n")
print("Network Block Count: #{j["networkBlockCount"]}\n")
print("Peer Count: #{j["peerCount"]}\n")
print("Hash Rate: #{j["hashrate"]}\n")
print("View Wallet: #{j["isViewWallet"]}\n")
print("Sub Wallet: #{j["subWalletCount"]}\n")


TurtleCoin.save_addresses

