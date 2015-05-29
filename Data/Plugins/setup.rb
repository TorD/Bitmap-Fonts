plugins = {
  "TDD_Ace_Bitmap_Fonts" => {
    order: [
      "Settings",
      :rest,
    ],
    "Engine Extensions" => {},
    "Parsers" => {
      "Standard Font Parser" => {
        order: [:rest, "load"]
      },
      "Image Font Parser" => {
        order: ["Settings", :rest, "load"]
      }
    },
    "Control Settings" => {}
  }
}

# REQUIRED: This is the root plugin directory (the one this file resides in).
ROOT_PATH = "Plugins"

# We now require the Plugins module
load_script "Data/#{ROOT_PATH}/plugins_module.rb"

Plugins.root_path = ROOT_PATH             
Plugins.load_recursive(plugins)
Plugins.package
load_script "Data/#{ROOT_PATH}/scripts.rb"