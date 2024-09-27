# treefmt.nix
{ ... }:
{
  projectRootFile = "flake.nix";
  programs.shfmt.enable = true;
  programs.nixfmt.enable = true;
}
