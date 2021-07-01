require_relative 'module_example'
puts TurtleCoin.get_balances
print("=========Info=========\n")
print("Address Count: " + TurtleCoin.address_count.to_s)
print("\n")
TurtleCoin.save_addresses