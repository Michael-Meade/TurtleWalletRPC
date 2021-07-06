require_relative 'module_example'
#TurtleCoin.auto_on
TurtleCoin.create_addresses(2).each do |k|
    p k["address"]
end

#puts TurtleCoin.private_key_transaction("9770e8e6e96f0488b59569447ff09d8a61109ee284aa1afa909575944d023548")
#puts TurtleCoin.create_addresses(2)
=begin
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
=end