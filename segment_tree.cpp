#include <vector>
using namespace std;

template <typename T>

class SegTree {

public:
    SegTree(T source[], int rsize, T func(T, T), T blank) {
        elems.resize(rsize * 4);
        this -> func = func;
        this -> blank = blank;
        act_size = rsize - 1;
        build(0, 0, act_size, source);
    }

    SegTree(vector <T> source, int rsize, T func(T, T), T blank) {
        elems.resize(rsize * 4);
        this -> func = func;
        this -> blank = blank;
        act_size = rsize - 1;
        build(0, 0, act_size, source);
    }

    T get(int from, int to) {
        return query(0, 0, act_size, from, to);
    }

    void setAt(int ind, T value) {
        modify(0, 0, act_size, ind, value);
    }
private:
    vector <T> elems;
    int act_size;
    T blank;

    T (*func) (T a, T b);

    int getMid(int lb, int rb) {
        return lb + (rb - lb) / 2;
    }

    void build(int ind, int left_border, int right_border, T source[]) {
        if (left_border == right_border) {
            elems[ind] = source[left_border];
            return;
        }

        int mid = getMid(left_border, right_border);
        int left_child = ind * 2 + 1;
        int right_child = ind * 2 + 2;

        build(left_child, left_border, mid, source);
        build(right_child, mid + 1, right_border, source);

        elems[ind] = func(elems[left_child], elems[right_child]);
    }

    T query(int ind, int left_border, int right_border, int requested_left, int requested_right) {
        if (left_border >= requested_left && right_border <= requested_right) {
            return elems[ind];
        }

        if (left_border > requested_right || right_border < requested_left) {
            return blank;
        }

        int mid = getMid(left_border, right_border);
        int left_child = ind * 2 + 1;
        int right_child = ind * 2 + 2;

        T left_child_res = query(left_child, left_border, mid, requested_left, requested_right);
        T right_child_res = query(right_child, mid + 1, right_border, requested_left, requested_right);

        return func(left_child_res, right_child_res);
    }

    void modify(int ind, int left_border, int right_border, int requested_ind, T new_value) {
        if (left_border > requested_ind || right_border < requested_ind) {
            return;
        }

        if (left_border == right_border) {
            elems[ind] = new_value;
            return;
        }

        int mid = getMid(left_border, right_border);
        int left_child = ind * 2 + 1;
        int right_child = ind * 2 + 2;

        modify(left_child, left_border, mid, requested_ind, new_value);
        modify(right_child, mid + 1, right_border, requested_ind, new_value);

        elems[ind] = func(elems[left_child], elems[right_child]);
    }
};
