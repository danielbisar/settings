#include "powerline.hpp"
#include <iostream>

Powerline::Powerline()
    : _segments(), _separator("\uE0B8")
{
}

Segment *Powerline::addSegment(const string &text, const string &bgColor, const string &fgColor)
{
    auto s = new Segment();

    s->text = text;
    s->bgColor = bgColor;
    s->fgColor = fgColor;
    s->end = _separator;

    _segments.push_back(s);
    return s;
}

void Powerline::setSeparator(const string &s)
{
    _separator = s;
}

void Powerline::write(ostream &os)
{
    for (int i = 0; i < _segments.size(); i++)
    {
        auto segment = _segments[i];

        cout << "\x1B[48;2;" << segment->bgColor << "m";
        cout << "\x1B[38;2;" << segment->fgColor << "m";
        cout << segment->text;

        if (i == _segments.size() - 1)
        {
            cout << "\x1B[49m"; // bg reset
            cout << "\x1B[38;2;" << segment->bgColor << "m";
        }
        else
        {
            cout << "\x1B[48;2;" << _segments[i + 1]->bgColor << "m";
            cout << "\x1B[38;2;" << segment->bgColor << "m";
        }

        cout << segment->end;
    }

    os << "\x1B[0m\n"; // reset
}
