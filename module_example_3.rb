require_relative 'module_example'
require_relative 'credits'
require 'securerandom'
require 'json'
class ExtractKey
    def get_key(key)
        key.split(//)[24..63].join
    end
end
class AddPayment
    def initialize(fingerprint)
        @fingerprint = fingerprint
        File.open(File.join("paid.txt").to_s, 'a') { |file| file.write("\n" + @fingerprint) }
    end
end

class GenPayId
    def initialize(fingerprints)
        @fingerprints = fingerprints
    end
    def fingerprints
        @fingerprints
    end
    def hex
        SecureRandom.hex(32)
    end
    def generate_payid
        payid = hex.split(//)[0..63 - fingerprints.length.to_i ].join
    return payid + fingerprints
    end
end
#5AC5C5D28F1DE43CA2AB60733478C7E0057ADA34

print("Enter FingerPrint:")
fprint = gets.chomp
Credits.new(fprint)
payid = GenPayId.new(fprint).generate_payid
addr  = TurtleCoin.primary_addr
out   = TurtleCoin.create_integrated(addr, payid)
puts "Please send 100 TRTL to: #{out["integratedAddress"]}\n"
WaitingDB.new(fprint).insert
