#include "lib-b/lib-b.h"

#include "lib-a/lib-a.h"

#include <numeric>

namespace lib_b
{

std::string flattened(const std::vector<std::string>& strs)
{
    return std::accumulate(
        std::begin(strs), std::end(strs), std::string{},
        [](std::string acc, const std::string& str)
        {
            acc.append(lib_a::trimmed(str));
            return acc;
        });
}

} // namespace lib_b
