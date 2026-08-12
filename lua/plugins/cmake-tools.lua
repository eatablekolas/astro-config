return {
  'Civitasv/cmake-tools.nvim',
  opts = {
    cmake_command = "cmake",
    cmake_regenerate_on_save = true,
    cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
    cmake_build_directory = "bin/${variant:buildType}",
    cmake_compile_commands_options = {
      action = "soft_link",
      target = vim.loop.cwd,
    },
  },
}
