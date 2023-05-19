
// The scoreboard is responsible to check data integrity. Since
// the design routes packets based on an address range, the
// scoreboard checks that the packet's address is within valid
// range.
class scoreboard;
  mailbox scb_mbx;

  task run();
    forever begin
      trans_obj item;
      scb_mbx.get(item);
      item.print({"[scoreboard]"});
    end
  endtask
endclass
