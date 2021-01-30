#pragma once

#include <string>
#include <algorithm>
#include <cctype>
#include <locale>

namespace lib_a
{
    [[nodiscard]] inline std::string trimmed(std::string str)
    {
        // note: inspiration taken from this excellent StackOverflow post:
        // https://stackoverflow.com/a/217605/1947066
        const auto ltrim = [](std::string& s) {
            s.erase(s.begin(), std::find_if(s.begin(), s.end(),
                [](const char ch) {
                    return !std::isspace(ch);
                }));
            };

        const auto rtrim = [](std::string& s) {
            s.erase(std::find_if(s.rbegin(), s.rend(),
                [](const char ch) {
                    return !std::isspace(ch);
                }).base(), s.end());
            };

        ltrim(str);
        rtrim(str);

        return str;
    }
} // namespace lib_a
