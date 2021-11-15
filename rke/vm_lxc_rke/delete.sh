for n in "n1 n2 n3"; do
  multipass stop $n
  multipass delete $n
done

multipass purge

rm -f cluster.rkestate
rm -f kube_config_cluster.yml
