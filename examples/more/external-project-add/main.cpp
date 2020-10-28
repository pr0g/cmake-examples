#include "bec/bitfield-enum-class.hpp"

#include <iostream>

enum class Key
{
    None    = 0,
    Red     = 1 << 0,
    Green   = 1 << 1,
    Blue    = 1 << 2,
    Purple  = 1 << 3,
    Yellow  = 1 << 4,
    Orange  = 1 << 5,
};

template<>
struct bec::EnableBitMaskOperators<Key>
{
    static const bool Enable = true;
};

enum class Team
{
    None    = 0,
    Green   = 1 << 0,
    Purple  = 1 << 1,
    Orange  = 1 << 2,
    Yellow  = 1 << 3,
    Red     = 1 << 4,
    Blue    = 1 << 5,
};

template<>
struct bec::EnableBitMaskOperators<Team>
{
    static const bool Enable = true;
};

// simple example program using bitfield-enum-class library
int main(int argc, char** argv) {
    using bec::operator&;
    using bec::operator|;
    using bec::operator|=;

    Key collected_keys = Key::None;
    collected_keys |= Key::Red | Key::Green;

    if ((collected_keys & Key::Red) == Key::Red) {
        std::cout << "Collected the Red key\n";
    }

    Team participating_teams = Team::None;
    participating_teams |= Team::Blue | Team::Purple;

    if ((participating_teams & Team::Blue) == Team::Blue) {
        std::cout << "Blue team is participating\n";
    }

    return 0;
}
