"""
Your awesome Distance Vector router for CS 168

Based on skeleton code by:
  MurphyMc, zhangwen0411, lab352
"""

import sim.api as api
from cs168.dv import RoutePacket, \
                     Table, TableEntry, \
                     DVRouterBase, Ports, \
                     FOREVER, INFINITY

class DVRouter(DVRouterBase):

    # A route should time out after this interval
    ROUTE_TTL = 15

    # Dead entries should time out after this interval
    GARBAGE_TTL = 10

    # -----------------------------------------------
    # At most one of these should ever be on at once
    SPLIT_HORIZON = False
    POISON_REVERSE = False
    # -----------------------------------------------

    # Determines if you send poison for expired routes
    POISON_EXPIRED = False

    # Determines if you send updates when a link comes up
    SEND_ON_LINK_UP = False

    # Determines if you send poison when a link goes down
    POISON_ON_LINK_DOWN = False

    def __init__(self):
        """
        Called when the instance is initialized.
        DO NOT remove any existing code from this method.
        However, feel free to add to it for memory purposes in the final stage!
        """
        assert not (self.SPLIT_HORIZON and self.POISON_REVERSE), \
                    "Split horizon and poison reverse can't both be on"

        self.start_timer()  # Starts signaling the timer at correct rate.

        # Contains all current ports and their latencies.
        # See the write-up for documentation.
        self.ports = Ports()

        # This is the table that contains all current routes
        self.table = Table()
        self.table.owner = self


    def add_static_route(self, host, port):
        """
        Adds a static route to this router's table.

        Called automatically by the framework whenever a host is connected
        to this router.

        :param host: the host.
        :param port: the port that the host is attached to.
        :returns: nothing.
        """
        # `port` should have been added to `peer_tables` by `handle_link_up`
        # when the link came up.
        assert port in self.ports.get_all_ports(), "Link should be up, but is not."

        # TODO: fill this in!
        self.table[host] = TableEntry(host, port, self.ports.get_latency(port), FOREVER)



    def handle_data_packet(self, packet, in_port):
        """
        Called when a data packet arrives at this router.

        You may want to forward the packet, drop the packet, etc. here.

        :param packet: the packet that arrived.
        :param in_port: the port from which the packet arrived.
        :return: nothing.
        """
        # TODO: fill this in!
        if self.table.get(packet.dst):
            if self.table.get(packet.dst).latency < INFINITY:
                self.send(packet, self.table.get(packet.dst).port)


    def send_routes(self, force=False, single_port=None):
        """
        Send route advertisements for all routes in the table.

        :param force: if True, advertises ALL routes in the table;
                      otherwise, advertises only those routes that have
                      changed since the last advertisement.
               single_port: if not None, sends updates only to that port; to
                            be used in conjunction with handle_link_up.
        :return: nothing.
        """
        # TODO: fill this in!
        # print("these are the table items: ")
        # print(self.table.items())
        if force:
            for host, entry in self.table.items():
                ad = RoutePacket(host, entry.latency)
                for port in self.ports.get_all_ports():
                    # print(ad)
                    if (entry.port != port) and (self.SPLIT_HORIZON):
                        self.send(ad, port)
                    elif self.POISON_REVERSE:
                        if (entry.port != port):
                            self.send(ad, port)
                        else:
                            self.send(RoutePacket(host, INFINITY), port)
                    else:
                        self.send(ad, port)
        # else:
        #     for host, entry in self.table.items():
        #         ad = RoutePacket(host, entry.latency)
        #         for port in self.ports.get_all_ports():
        #             if entry.port != port:
        #                 self.send(ad, port)


    def expire_routes(self):
        """
        Clears out expired routes from table.
        accordingly.
        """
        # TODO: fill this in!
        keys = self.table.items()
        delete = []

        for dst, entry in keys:
            if entry.has_expired:
                delete.append(dst)

        if not self.POISON_EXPIRED:
            for dest in delete:
                self.table.pop(dest)
        else:
            for dest in delete:
                self.table[dest] = TableEntry(dest, self.table[dest].port, INFINITY, api.current_time() + self.ROUTE_TTL)
                # ad = RoutePacket(dest, INFINITY)
                    # for port in self.ports.get_all_ports():
                    #     self.send(ad, port)



    def handle_route_advertisement(self, route_dst, route_latency, port):
        """
        Called when the router receives a route advertisement from a neighbor.

        :param route_dst: the destination of the advertised route.
        :param route_latency: latency from the neighbor to the destination.
        :param port: the port that the advertisement arrived on.
        :return: nothing.
        """
        # TODO: fill this in!
        if route_dst in self.table:
            current_route = self.table.get(route_dst)
            if (route_latency + self.ports.get_latency(port) < current_route.latency) or (port == self.table[route_dst].port):
                if route_latency >= INFINITY:
                    self.table[route_dst] = TableEntry(route_dst, port, route_latency, api.current_time())
                else:
                    self.table[route_dst] = TableEntry(route_dst, port, route_latency + self.ports.get_latency(port), api.current_time() + self.ROUTE_TTL)

        else:
            if (route_latency < INFINITY):
                self.table[route_dst] = TableEntry(route_dst, port, route_latency + self.ports.get_latency(port), api.current_time() + self.ROUTE_TTL)



    def handle_link_up(self, port, latency):
        """
        Called by the framework when a link attached to this router goes up.

        :param port: the port that the link is attached to.
        :param latency: the link latency.
        :returns: nothing.
        """
        self.ports.add_port(port, latency)

        # TODO: fill in the rest!

    def handle_link_down(self, port):
        """
        Called by the framework when a link attached to this router does down.

        :param port: the port number used by the link.
        :returns: nothing.
        """
        self.ports.remove_port(port)

        # TODO: fill this in!

    # Feel free to add any helper methods!
