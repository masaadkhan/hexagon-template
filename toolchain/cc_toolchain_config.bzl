load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",    # NEW
    "flag_group", # NEW
    "flag_set",   # NEW
    "tool_path",
)

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

def _impl(ctx):
    tool_paths = [
        tool_path(
            name = "gcc",
            path = "/usr/bin/clang-19",
        ),
        tool_path(
            name = "ld",
            path = "/usr/bin/ld",
        ),
        tool_path(
            name = "ar",
            path = "/usr/bin/ar",
        ),
        tool_path(
            name = "cpp",
            path = "/bin/false",
        ),
        tool_path(
            name = "gcov",
            path = "/bin/false",
        ),
        tool_path(
            name = "nm",
            path = "/bin/false",
        ),
        tool_path(
            name = "objdump",
            path = "/bin/false",
        ),
        tool_path(
            name = "strip",
            path = "/bin/false",
        ),
    ]

    features = [
        feature(
            name = "default_linker_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_link_actions,
                    flag_groups = ([
                        flag_group(
                            flags = [
                                "-lstdc++",
                            ],
                        ),
                    ]),
                ),
            ],
        ),
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        cxx_builtin_include_directories = [
            "/usr/lib/llvm-19/lib/clang/19/include",
            "/usr/include",
        ],
        toolchain_identifier = "local",
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = "k8",
        target_libc = "unknown",
        compiler = "clang",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)

hexagon_path        = "/Documents/VLIW/clang+llvm-20.1.4-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu"
hexagon_sysroot     = hexagon_path + "/target/hexagon-unknown-linux-musl"
hexagon_bin_path    = hexagon_path + "/bin"

hexagon_inc_cxx     = hexagon_sysroot + "/usr/include/c++/v1"
hexagon_inc_sys     = hexagon_sysroot + "/usr/include"
hexagon_inc_clang   = hexagon_path + "/lib/clang/20/include"

def _hexagon_impl(ctx):
    tool_paths = [
        tool_path(
            name = "gcc",
            path = hexagon_bin_path + "/clang",
        ),
        tool_path(
            name = "ld",
            path = hexagon_bin_path + "/ld",
        ),
        tool_path(
            name = "ar",
            path = hexagon_bin_path + "/llvm-ar",
        ),
        tool_path(
            name = "cpp",
            path = "/bin/false",
        ),
        tool_path(
            name = "gcov",
            path = "/bin/false",
        ),
        tool_path(
            name = "nm",
            path = "/bin/false",
        ),
        tool_path(
            name = "objdump",
            path = hexagon_bin_path + "/llvm-objdump",
        ),
        tool_path(
            name = "strip",
            path = hexagon_bin_path + "/llvm-strip",
        ),
    ]

    features = [
        feature(
            name = "default_linker_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_link_actions,
                    flag_groups = ([
                        flag_group(
                            flags = [
                                "-lstdc++",
                            ],
                        ),
                    ]),
                ),
            ],
        ),
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        cxx_builtin_include_directories = [
            hexagon_inc_cxx,
            hexagon_inc_sys,
            hexagon_inc_clang,
        ],
        toolchain_identifier = "hexagon-toolchain",
        host_system_name = "local",
        target_system_name = "hexagon",
        target_cpu = "hexagon",
        target_libc = "unknown",
        compiler = "hexagon-clang",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
    )

hexagon_cc_toolchain_config = rule(
    implementation = _hexagon_impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
