import byte

-- Constants of type Byte

byte_zero : Byte
byte_zero = MkByte B0 B0

byte_one: Byte
byte_one = MkByte B0 B1

byte_two: Byte
byte_two = MkByte B1 B0

byte_three: Byte
byte_three = MkByte B1 B1

-- Let' add two bits and get a byte
bit_sum: Byte
bit_sum = byte_bit_plus B1 B1
-- expect 10 (MkByte (MkBit True) (MkBit False))
