METRICS="node_netstat_Ip_Forwarding node_netstat_TcpExt_ListenDrops node_netstat_TcpExt_ListenOverflows node_netstat_TcpExt_SyncookiesFailed node_netstat_TcpExt_SyncookiesRecv node_netstat_TcpExt_SyncookiesSent node_netstat_TcpExt_TCPSynRetrans node_netstat_Tcp_ActiveOpens node_netstat_Tcp_CurrEstab node_netstat_Tcp_InErrs node_netstat_Tcp_InSegs node_netstat_Tcp_OutSegs node_netstat_Tcp_PassiveOpens node_netstat_Tcp_RetransSegs node_netstat_Udp6_InDatagrams node_netstat_Udp6_InErrors node_netstat_Udp6_NoPorts node_netstat_Udp6_OutDatagrams node_netstat_UdpLite6_InErrors node_netstat_UdpLite_InErrors node_netstat_Udp_InDatagrams node_netstat_Udp_InErrors node_netstat_Udp_NoPorts node_netstat_Udp_OutDatagrams node_network_address_assign_type node_network_carrier node_network_carrier_changes_total node_network_carrier_down_changes_total node_network_carrier_up_changes_total node_network_device_id node_network_dormant node_network_flags node_network_iface_id node_network_iface_link node_network_iface_link_mode node_network_info node_network_mtu_bytes node_network_name_assign_type node_network_net_dev_group node_network_protocol_type  node_network_transmit_queue_length node_network_up node_nf_conntrack_entries node_nf_conntrack_entries_limit node_netstat_Icmp6_InErrors node_netstat_Icmp6_InMsgs node_netstat_Icmp6_OutMsgs node_netstat_Icmp_InErrors node_netstat_Icmp_InMsgs node_netstat_Icmp_OutMsgs node_netstat_Ip6_InOctets node_netstat_Ip6_OutOctets node_netstat_IpExt_InOctets node_netstat_IpExt_OutOctets node_network_receive_bytes_total node_network_receive_compressed_total node_network_receive_drop_total node_network_receive_errs_total node_network_receive_fifo_total node_network_receive_frame_total node_network_receive_multicast_total node_network_receive_packets_total node_network_speed_bytes node_network_transmit_bytes_total node_network_transmit_carrier_total node_network_transmit_colls_total node_network_transmit_compressed_total node_network_transmit_drop_total node_network_transmit_errs_total node_network_transmit_fifo_total node_network_transmit_packets_total node_sockstat_FRAG_inuse node_sockstat_FRAG_memory node_sockstat_RAW_inuse node_sockstat_TCP_alloc node_sockstat_TCP_inuse node_sockstat_TCP_mem node_sockstat_TCP_mem_bytes node_sockstat_TCP_orphan node_sockstat_TCP_tw node_sockstat_UDPLITE_inuse node_sockstat_UDP_inuse node_sockstat_UDP_mem node_sockstat_UDP_mem_bytes node_sockstat_sockets_used"
OUTDIR=metrics/network
PERIOD=6h
mkdir -p $OUTDIR
for METRIC in $METRICS; do
oc exec -c prometheus -n openshift-monitoring prometheus-k8s-0 -- curl --data-urlencode "query=$METRIC[$PERIOD]" http://localhost:9090/api/v1/query > $OUTDIR/$METRIC
done
