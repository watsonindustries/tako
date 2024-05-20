{ pkgs, ... }:

{
  languages = {
    nix.enable = true;
    shell.enable = true;
    elixir = {
      enable = true;
      package = pkgs.beam.packages.erlangR26.elixir_1_16;
    };
  };

  env = { ERL_FLAGS = "-kernel shell_history enabled"; };

  # https://devenv.sh/packages/
  packages = [ pkgs.git ];

  enterShell = ''
    export PATH="$HOME/.mix/escripts:$PATH"
  '';

  # https://devenv.sh/scripts/
  scripts = {
    
  };

  services.postgres = {
    enable = true;
    package = pkgs.postgresql_15;
    initialDatabases =
      [ { name = "tako_development"; } { name = "tako_test"; } ];
    initialScript = ''
      CREATE USER tako SUPERUSER;
      ALTER USER tako WITH PASSWORD 'tako';
    '';
    listen_addresses = "127.0.0.1";
    port = 5432;
  };

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks = {
    
  };

  # https://devenv.sh/processes/
  # processes.ping.exec = "ping example.com";

  # See full reference at https://devenv.sh/reference/options/
}