const std = @import("std");

pub fn build(b: *std.Build) void {
    _ = b.addModule("bitstream", .{
        .root_source_file = b.path("main.zig"),
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });
}
