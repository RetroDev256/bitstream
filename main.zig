const std = @import("std");
const Reader = std.Io.Reader;
const Writer = std.Io.Writer;

buffer: u8,
bits: u3,

pub const init: @This() = .{
    .bits = 0,
    .buffer = undefined,
};

/// Read a single bit from the reader.
pub fn read(self: *@This(), reader: *Reader) !u1 {
    if (self.bits == 0) {
        @branchHint(.unlikely);
        self.buffer = try reader.takeByte();
    }
    self.bits -%= 1;
    return @truncate(self.buffer >> self.bits);
}

//// Write a single bit to the writer.
pub fn write(self: *@This(), writer: *Writer, bit: u1) !void {
    const select: u8 = @as(u8, 1) << (7 - self.bits);
    self.buffer = (self.buffer & ~select) | (select * bit);
    if (self.bits == 7) {
        @branchHint(.unlikely);
        try writer.writeByte(self.buffer);
    }
    self.bits +%= 1;
}

/// Write the bit buffer to the writer. This may include undefined bits.
/// To ensure the written byte is defined, only write in multiples of 8.
pub fn flush(self: *@This(), writer: *Writer) !void {
    if (self.bits != 0) {
        try writer.writeByte(self.buffer);
    }
}
