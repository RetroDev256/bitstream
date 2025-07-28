# BitStream

Ultra simple bit reading / bit writing for std.Io.Reader and std.Io.Writer.

```zig
const BitStream = @import("BitStream");

// Initialize a BitStream:
var bit_stream: BitStream = .init;

// Read one bit from a std.Io.Reader:
const read_bit: u1 = try bit_stream.read(reader);

// Write one bit to a std.Io.Writer:
try bit_stream.write(writer, read_bit);

// Flush bit buffer to the writer (pads with undefined bits)
try bit_stream.flush(writer);

// This field is the current bit buffer:
_ = bit_stream.buffer; // u8

// This field is the number of bits in the buffer:
_ = bit_stream.bits; // u3
```
