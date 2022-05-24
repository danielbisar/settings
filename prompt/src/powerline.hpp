#pragma once

#include <string>
#include <vector>

using namespace std;

class Segment
{
public:
    string text;
    string bgColor;
    string fgColor;
    string end;
};

class Powerline
{
private:
    vector<Segment *> _segments;
    string _separator;

public:
    Powerline();

    Segment *addSegment(const string &text, const string &bgColor, const string &fgColor);

    void setSeparator(const string &s);

    void write(ostream &os);
};
