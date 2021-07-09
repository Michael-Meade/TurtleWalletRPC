require 'securerandom'
class HexSpeak
    def pick_speak
        File.readlines("hexspeak.txt").sample
    end
    def count(c = 0)
        pick = []
        for i in 0..c.to_i
            pick << pick_speak.strip
        end
    return pick.join
    end
end

pay  = HexSpeak.new.count(6)
hex  = SecureRandom.hex(32)
puts hex.split(//)[0..63 - pay.length.to_i ].join + pay