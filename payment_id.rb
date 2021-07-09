require 'securerandom'
require 'json'
require 'TurtleCoin'

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

class HexSpeak
    def pick_speak
        File.readlines("hexspeak.txt").sample
    end
    def count(c = 0)
        pick = []
        for i in 0..c.to_i
            pick << pick_speak
        end
    return pick.join
    end
end

l = HexSpeak.new.count(2)
puts l
class GenPayIdV2
    def initialize(fingerprints)
        @fingerprints = fingerprints
    end
    def fingerprints
        @fingerprints
    end
    def test
        hex
    end
    def hex
        SecureRandom.hex(32)
    end
end
class SavePayment
    def initialize(payment_id)
        @payment_id = payment_id.downcase
        puts "PPPP> #{@payment_id}"
        File.open(File.join("waiting_payment.txt").to_s, 'a') { |file| file.write("\n" + @payment_id) }
    end

end
w       = Wallet.new
payid   = GenPayId.new("5AC5C5D28F1DE43CA2AB60733478C7E0057ADA34").generate_payid
addr    = w.address_primary.to_h["address"]
address = JSON.parse(w.create_integrated_address(addr, payid))["integratedAddress"]
puts "#{payid}"
puts "New address: #{address}\n"
SavePayment.new(payid)

#payid   = GenPayId.new("5AC5C5D28F1DE43CA2AB60733478C7E0057ADA34").generate_payid
#DeletePayment.new("0741d73f3fa7c0634e2a98285AC5C5D28F1DE43CA2AB60733478C7E0057ADA34")


# puts payid
# puts "GPG fingerprint: #{pay}"
