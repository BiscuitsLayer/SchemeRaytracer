#pragma once

#include <random>
#include <vector>
#include <algorithm>
#include <numeric>
#include <filesystem>

std::vector<std::string> Split(const std::string& string, const std::string& delimiter = " ",
                               bool filter_empty = false) {
    std::vector<std::string> ans{};
    std::string temp{};

    size_t cur_idx = 0;
    size_t delim_idx = 0;
    while (delim_idx != std::string::npos) {
        delim_idx = string.find(delimiter, cur_idx);
        std::string temp = {string.substr(cur_idx, delim_idx - cur_idx)};
        if (!temp.empty() || (temp.empty() && !filter_empty)) {
            ans.emplace_back(temp);
        }
        if (delim_idx == std::string::npos) {
            break;
        }
        cur_idx = delim_idx + delimiter.size();
    }
    return ans;
}

class RandomGenerator {
public:
    explicit RandomGenerator(uint32_t seed = 738547485u) : gen_(seed) {
    }

    template <class T>
    std::vector<T> GenIntegralVector(size_t count, T from, T to) {
        std::uniform_int_distribution<T> dist(from, to);
        std::vector<T> result(count);
        for (auto& cur : result) {
            cur = dist(gen_);
        }
        return result;
    }

    std::string GenString(size_t count, char from = 'a', char to = 'z') {
        std::uniform_int_distribution<int> dist(from, to);
        std::string result(count, from);
        for (char& x : result) {
            x = static_cast<char>(dist(gen_));
        }
        return result;
    }

    std::vector<double> GenRealVector(size_t count, double from, double to) {
        std::uniform_real_distribution<double> dist(from, to);
        std::vector<double> result(count);
        for (auto& cur : result) {
            cur = dist(gen_);
        }
        return result;
    }

    std::vector<int> GenPermutation(size_t count) {
        std::vector<int> result(count);
        std::iota(result.begin(), result.end(), 0);
        std::shuffle(result.begin(), result.end(), gen_);
        return result;
    }

    template <class T>
    T GenInt(T from, T to) {
        std::uniform_int_distribution<T> dist(from, to);
        return dist(gen_);
    }

    template <class T>
    T GenInt() {
        return GenInt(std::numeric_limits<T>::min(), std::numeric_limits<T>::max());
    }

    template <class Iterator>
    void Shuffle(Iterator first, Iterator last) {
        std::shuffle(first, last, gen_);
    }

private:
    std::mt19937 gen_;
};

inline std::filesystem::path GetFileDir(std::string file) {
    std::filesystem::path path{std::move(file)};
    if (path.is_absolute() && std::filesystem::is_regular_file(path)) {
        return path.parent_path();
    } else {
        throw std::runtime_error{"Bad file name"};
    }
}
