require_relative 'module_example'
#TurtleCoin.auto_on



#puts TurtleCoin.create_addresses(2)
i     = TurtleCoin.transaction_info("9")
trans = i["transfers"].shift
puts i["hash"]
puts trans["address"]
puts i["paymentID"]
puts i["blockHeight"]
puts i["fee"]
puts i["timestamp"]
puts trans["amount"]
puts i["unlockTime"]
puts i["isCoinbaseTransaction"]