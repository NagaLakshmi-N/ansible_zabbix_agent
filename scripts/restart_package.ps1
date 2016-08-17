param(
   [String] $package_path,
   [String] $config_path
)


cmd /c "$package_path" --config "$config_path" --stop
cmd /c "$package_path" --config "$config_path" --start
