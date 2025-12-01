## What is a Transit Gateway?
AWS Transit Gateway is a network transit hub that enables you to connect your Amazon Virtual Private Clouds (VPCs) and on-premises networks through a single gateway. It acts as a central hub for routing traffic between multiple VPCs and on-premises networks, simplifying network architecture and management.
Supports both IPv4 and IPv6

## Key Features of AWS Transit Gateway
- **Centralized Connectivity**: Connect multiple VPCs and on-premises networks through a
    single gateway, reducing the complexity of managing multiple connections.
- **Scalability**: Automatically scales to accommodate growing network traffic and
    connections.
- **High Availability**: Designed for high availability with built-in redundancy and failover
    capabilities.
- **Simplified Management**: Provides a single point of management for all network connections,
    making it easier to monitor and control traffic flow.
- **Inter-Region Peering**: Enables you to connect Transit Gateways across different AWS
    regions for global network connectivity.
- **Multicast Support**: Allows you to use multicast protocols within your VPCs connected
    to the Transit Gateway.

## Use Cases
- **Hub-and-Spoke Network Architecture**: Simplifies the management of complex network
    architectures by centralizing connectivity.
- **Hybrid Cloud Connectivity**: Connect on-premises data centers with multiple VPCs in
    AWS.
- **Inter-Region Connectivity**: Facilitate communication between VPCs in different AWS
    regions.
- **Simplified Network Management**: Centralize and streamline the management of network
    connections.

## Components of AWS Transit Gateway
- **Transit Gateway**: The central hub that connects VPCs and on-premises networks
- **Attachments**: Connections between the Transit Gateway and VPCs or on-premises networks
- **Route Tables**: Define how traffic is routed between attachments
- **Peering Connections**: Enable communication between Transit Gateways in different regions
