require("typescript-tools").setup {
  settings = {
    expose_as_code_action = "all",
    tsserver_file_preferences = {
      importModuleSpecifierPreference = "non-relative",
    },
  }
}
