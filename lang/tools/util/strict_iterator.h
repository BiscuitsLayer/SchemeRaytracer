#pragma once

#include <type_traits>

template <class Iterator>
class StrictIterator {
public:
    using iterator_category = std::bidirectional_iterator_tag;   // NOLINT
    using value_type = typename Iterator::value_type;            // NOLINT
    using difference_type = typename Iterator::difference_type;  // NOLINT
    using pointer = typename Iterator::pointer;                  // NOLINT
    using reference = typename Iterator::reference;              // NOLINT
    using Reference = reference;

    StrictIterator() {
    }

    StrictIterator(Iterator first, Iterator current, Iterator last)
        : first_(first), current_(current), last_(last) {
        is_init_ = true;
    }

    StrictIterator& operator++() {
        CheckInit();
        if (current_ == last_) {
            throw std::range_error("out of range (right)");
        }
        ++current_;
        return *this;
    }

    StrictIterator operator++(int) {
        CheckInit();
        StrictIterator old(*this);
        this->operator++();
        return old;
    }

    StrictIterator& operator--() {
        CheckInit();
        if (current_ == first_) {
            throw std::range_error("out of range (left)");
        }
        --current_;
        return *this;
    }

    StrictIterator operator--(int) {
        CheckInit();
        StrictIterator old(*this);
        this->operator--();
        return old;
    }

    Reference operator*() {
        CheckInit();
        if (current_ == last_) {
            throw std::range_error("dereferencing end of sequence");
        }
        return *current_;
    }

    const Reference operator*() const {
        CheckInit();
        if (current_ == last_) {
            throw std::range_error("dereferencing end of sequence");
        }
        return *current_;
    }

    auto operator->() {
        CheckInit();
        return &(this->operator*());
    }

    auto operator->() const {
        CheckInit();
        return &(this->operator*());
    }

    bool operator==(const StrictIterator& r) const {
        return current_ == r.current_;
    }

    bool operator!=(const StrictIterator& r) const {
        return !(current_ == r.current_);
    }

private:
    Iterator first_, current_, last_;
    bool is_init_ = false;

    void CheckInit() {
        if (!is_init_) {
            throw std::runtime_error("Using uninitialized iterator");
        }
    }
};

template <class Iterator>
StrictIterator<Iterator> MakeStrict(Iterator first, Iterator current, Iterator last) {
    return StrictIterator<Iterator>(first, current, last);
}
