requires 'Encode';
requires 'Getopt::Long', '2.39';
requires 'Module::Load';
requires 'Mouse';
requires 'Mouse::Util::TypeConstraints';
requires 'Path::Tiny';
requires 'String::CamelCase';
requires 'perl', '5.008001';

on configure => sub {
    requires 'CPAN::Meta';
    requires 'CPAN::Meta::Prereqs';
    requires 'Module::Build';
};

on test => sub {
    requires 'Capture::Tiny';
    requires 'Test::Fatal';
    requires 'Test::More', '0.98';
};
