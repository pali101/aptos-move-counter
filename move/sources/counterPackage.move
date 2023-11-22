module counter_addr::CounterPackage {
    use std::signer;

    const E_NOT_INITIALIZED: u64 = 1;
    const E_NOT_MODULE_OWNER: u64 = 2;
    const MODULE_OWNER: address = @counter_addr;

    struct GlobalCounter has key {
        counter: u64
    }

    public entry fun initialize_counter(account: &signer) {
        // initialization can only be done by the module owner
        assert!(signer::address_of(account) == MODULE_OWNER, E_NOT_MODULE_OWNER);
        let counter = GlobalCounter { counter: 0 };
        move_to(account, counter);
    }

    // public fun get_count(addr:address): u64 acquires ClickCounter {
    //     assert!(exists<ClickCounter>(addr), E_NOT_INITIALIZED);
    //     borrow_global<ClickCounter>(addr).counter
    // }

    public fun get_global_count(): u64 acquires GlobalCounter {
        assert!(exists<GlobalCounter>(MODULE_OWNER), E_NOT_INITIALIZED);
        borrow_global<GlobalCounter>(MODULE_OWNER).counter
    }

    public entry fun click(account: &signer) acquires GlobalCounter {
        // gets the signer address
        // let signer_address = signer::address_of(account);
        // assert signer has created a list
        // assert!(exists<ClickCounter>(signer_address), E_NOT_INITIALIZED);

        assert!(exists<GlobalCounter>(MODULE_OWNER), E_NOT_INITIALIZED);

        let get_global_counter = borrow_global_mut<GlobalCounter>(MODULE_OWNER);
        get_global_counter.counter = get_global_counter.counter + 1;
    }
    
}