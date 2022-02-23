# generic

This terraform is different in that it doesn't deploy any cloud resources. It's using remote-exec to deploy
the wireguard setup on a remote machine and then returns the local wireguard config.
