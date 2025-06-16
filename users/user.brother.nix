{ lib, config, pkgs, ... }:

{

  users.users.brother = {
    uid = 1405;   # could be removed
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9ZLjbgsqe1O1y+b2mnpDfDzbvL53qhL7Fh8K3v48mh+BTM/Eu27h4SnhY7NLUheb6aK/6hhcI6JQqSZfN7LnNVGvMwrAqA8CGAwiFG6t3UCzFuNPX2maq5av66iLw6LCt8KYDAKTmvIgA50SE0V7UeXq7PKSD/PYRaU86U4YdgCFJtMeN02DDiQ7kghTVUZ2G9PA+alvn514ZlKJXIqm/dN9YkLzDrxygBoOAkTBvXy+oSX0U3vnj6Y4UiA7Q9ZPwEmKGM+1ugFftbtFqTb7zLU7GrrOBC45nlgSMcGqNT6oNgDz8rMA84Xp1ckLNoAYZ+T9ytamxAa3+aeTYX7ZF" ];
    #password = "testtest";
  };

}
