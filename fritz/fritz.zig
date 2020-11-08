const std = @import("std");
const allocator = std.heap.page_allocator;

pub fn main() !void {
    const stdout_file = std.io.getStdOut();

    var arg_it = std.process.args();
    _ = arg_it.skip();

    while (arg_it.next(allocator)) |filename| {
        const file = try std.fs.cwd().openFile(
            try filename,
            .{ .read = true },
        );
        defer file.close();

        _ = try stdout_file.writeFileAll(file, .{});
    }
}

