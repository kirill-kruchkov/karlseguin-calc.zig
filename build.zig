const std = @import("std");

pub fn build(b: *std.Build) !void {
	const target = b.standardTargetOptions(.{});
	const optimize = b.standardOptimizeOption(.{});

	_ = b.addModule("calc", .{
		.root_source_file = b.path("calc.zig"),
	});

	const tests = b.addTest(.{
		.target = target,
		.optimize = optimize,
		.root_source_file = b.path("calc.zig"),
	});

	const test_cmd = b.addRunArtifact(tests);
	test_cmd.step.dependOn(b.getInstallStep());
	const test_step = b.step("test", "Run the tests");
	test_step.dependOn(&test_cmd.step);
}
