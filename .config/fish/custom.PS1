#!perl
use utf8;
use strict;
use warnings;

use AngelPS1::Chrome;

use constant {
    # Separator characters
    # Powerline font support must have been installed in the X11 terminal
    # See https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation
    SEP_COLOR   => "\x{E0B0}",
    SEP_THIN    => "\x{E0B1}",

    USERNAME_BG  => color(25),
    USERNAME_FG  => color(231),
    HOSTNAME_BG  => color(32),
    PATH_BG      => color(240),
    PATH_FG      => color(250),
    SEPARATOR_FG => color(245),
    CWD_FG       => color(252),
    CWD_BG       => color(242),
    PROMPT_COLOR => color(2),
};

return (
    USERNAME_FG / USERNAME_BG + Reset + Bold,
    '  ',
    $ENV{USER},
    ' ',
    USERNAME_BG / HOSTNAME_BG + Reset + Bold,
    SEP_COLOR,
    USERNAME_FG / HOSTNAME_BG + Reset + Bold,
    ' 歷',
    do {
        chomp(my ($hostname) = `hostname | cut -f 1 -d.`);
        $hostname
    },
    ' ',
    HOSTNAME_BG / PATH_BG + Reset,
    SEP_COLOR,
    PATH_FG,
    '  ',
    PATH_BG / CWD_BG + Reset,
    SEP_COLOR,
    PATH_FG / CWD_BG + Reset,
    # Display of the current path
    # '/' is replaced by SEP_THIN colored with FG_PWD_SEP
    # Each element of the path is colored with FG_PWD
    # The last element is colored with FG_PWD_LAST
    do {
        # Build invariants just once
        my $home_regexp = qr{^\Q$ENV{HOME}\E(?:/|$)};
        my $color_last = CWD_FG + Bold;

        sub {
            my $dir = shift->{PWD};
            my @cwd;
            # Below $HOME ?
            if ($dir =~ s{$home_regexp}{}s) {
                @cwd = ('~', split m!/!, $dir)
            } else {
                @cwd = split m!/!, $dir;
                $cwd[0] = '/';
            }
            my $last = pop @cwd;

            my $arrlen = @cwd;
            my $dirs = "";

            if ($arrlen == 0) {
                $dirs = $color_last . " $last ";
            } elsif ($arrlen == 1) {
                $dirs = " $cwd[0] " . SEP_THIN . $color_last . " $last ";
            } elsif ($arrlen > 2) {
                $dirs = " $cwd[0] " . SEP_THIN . " $cwd[1] " . SEP_THIN . " … " . SEP_THIN . $color_last . " $last ";
            } elsif ($arrlen == 2) {
                $dirs = " $cwd[0] " . SEP_THIN . " $cwd[1] " . SEP_THIN . $color_last . " $last ";
            }
            
            $dirs
        }
    },
    CWD_BG / USERNAME_BG + Reset,
    SEP_COLOR,
    USERNAME_FG / USERNAME_BG + Reset,
    # TODO: git branch and status
    do {
        sub {
            chomp(my ($battlevelstr) = `cat /sys/class/power_supply/BAT0/capacity 2> /dev/null`);
            my $battlevel = $battlevelstr + 0;
            my $icon = '';
            if ($battlevel >= 0 && $battlevel <= 10) {
                $icon = '  ';
            } elsif ($battlevel >= 11 && $battlevel <= 25) {
                $icon = '  ';
            } elsif ($battlevel >= 26 && $battlevel <= 50) {
                $icon = '  ';
            } elsif ($battlevel >= 51 && $battlevel <= 75) {
                $icon = '  ';
            } elsif ($battlevel >= 76 && $battlevel <= 100) {
                $icon = '  ';
            }
            $icon . $battlevelstr . '%'
        }
    },
    ' ',
    USERNAME_BG / HOSTNAME_BG + Reset,
    SEP_COLOR,
    USERNAME_FG / HOSTNAME_BG + Reset + Bold,
    '  ',
    do {
        sub {
            chomp(my ($date) = `date +"%b %d %H:%M %p"`);
      
            $date . ' '
        }
    },
    do {
        sub {
            my @ret = (HOSTNAME_BG + Reset + Bold, SEP_COLOR);

            chomp(my $unused = `git rev-parse --is-inside-work-tree 2>&1 > /dev/null`);

            my $col = Reset;

            if ($? == 0) {
                 chomp(my $retv = `git status --porcelain --ignore-submodules 2> /dev/null`);
                 if (length($retv) == 0) {
                    @ret = (HOSTNAME_BG / Green + Reset + Bold, SEP_COLOR, USERNAME_FG / Green + Reset + Bold);
                    $col = Green;
                 } else {
                    @ret = (HOSTNAME_BG / Red + Reset + Bold, SEP_COLOR, USERNAME_FG / Red + Reset + Bold);
                    $col = Red;
                 }

                 chomp(my $symref = `git symbolic-ref HEAD --short -q 2> /dev/null`);

                 if ($? != 0) {
                    chomp(my $dhref = `git rev-parse --short HEAD 2> /dev/null`);
                    push(@ret, (
                        "  $dhref ", $col + Reset + Bold . SEP_COLOR
                    ));
                 } else {
                    push(@ret, (
                        " שׂ $symref ", $col + Reset + Bold . SEP_COLOR
                    ));
                 }
            #    
            }

            @ret
        }
    },
    " \n",
    PROMPT_COLOR + Reset + Bold,
    " ",
    Reset
)
__END__
# vim:set et ts=8 sw=4 sts=4:
