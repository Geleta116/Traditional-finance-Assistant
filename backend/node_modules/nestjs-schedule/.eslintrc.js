module.exports = {
    parser: '@typescript-eslint/parser',
    parserOptions: {
        project: 'tsconfig.json',
        sourceType: 'module',
    },
    plugins: ['@typescript-eslint/eslint-plugin'],
    extends: [
        'plugin:@typescript-eslint/recommended',
        'plugin:prettier/recommended',
        'prettier',
    ],
    root: true,
    env: {
        node: true,
        jest: true,
    },
    ignorePatterns: ['.eslintrc.js', 'build/**', 'buildDev/**'],
    rules: {
        'multiline-ternary': 'always-multiline',
        'arrow-parens': ['error', 'as-needed'],
        'prettier/prettier': ['error', { tabWidth: 4 }],
        '@typescript-eslint/interface-name-prefix': 'off',
        '@typescript-eslint/explicit-function-return-type': 'off',
        '@typescript-eslint/explicit-module-boundary-types': 'off',
        '@typescript-eslint/no-explicit-any': 'off',
        '@typescript-eslint/adjacent-overload-signatures': 2,
        '@typescript-eslint/array-type': [
            1,
            {
                default: 'array-simple',
            },
        ],
        '@typescript-eslint/ban-tslint-comment': 1,
        '@typescript-eslint/ban-types': [
            2,
            {
                extendDefaults: true,
                types: {
                    '{}': false,
                    object: false,
                },
            },
        ],
        '@typescript-eslint/class-literal-property-style': 1,
        // '@typescript-eslint/consistent-indexed-object-style': 2,
        '@typescript-eslint/consistent-type-assertions': 2,
        '@typescript-eslint/consistent-type-definitions': [2, 'interface'],
        '@typescript-eslint/member-delimiter-style': [1],
        // '@typescript-eslint/member-ordering': 1,
        '@typescript-eslint/naming-convention': [
            'error',
            {
                selector: 'typeLike',
                format: ['PascalCase'],
            },
        ],
        '@typescript-eslint/no-confusing-non-null-assertion': 2,
        '@typescript-eslint/no-empty-interface': 2,
        '@typescript-eslint/no-extra-non-null-assertion': 2,
        '@typescript-eslint/no-extraneous-class': 2,
        '@typescript-eslint/no-invalid-void-type': 1,
        '@typescript-eslint/no-misused-new': 2,
        '@typescript-eslint/no-namespace': 2,
        '@typescript-eslint/no-non-null-asserted-optional-chain': 1,
        '@typescript-eslint/no-parameter-properties': [
            2,
            {
                allows: [
                    'readonly',
                    'private',
                    'protected',
                    'public',
                    'private readonly',
                    'protected readonly',
                    'public readonly',
                ],
            },
        ],
        '@typescript-eslint/no-redeclare': [
            2,
            {
                ignoreDeclarationMerge: true,
            },
        ],
        '@typescript-eslint/no-require-imports': 2,
        '@typescript-eslint/no-var-requires': 2,
        '@typescript-eslint/no-this-alias': [
            'error',
            {
                allowDestructuring: true, // Allow `const { props, state } = this`; false by default
                allowedNames: ['self'], // Allow `const self = this`; `[]` by default
            },
        ],
        '@typescript-eslint/no-unnecessary-type-constraint': 1,
        '@typescript-eslint/prefer-as-const': 1,
        // '@typescript-eslint/prefer-function-type': 1,
        '@typescript-eslint/prefer-literal-enum-member': 2,
        '@typescript-eslint/triple-slash-reference': 2,
        '@typescript-eslint/type-annotation-spacing': 1,
        '@typescript-eslint/unified-signatures': 1,

        'no-unused-vars': 0,
        '@typescript-eslint/no-unused-vars': [
            1,
            {
                vars: 'all',
                args: 'after-used',
                ignoreRestSiblings: true,
                varsIgnorePattern: '^_',
                argsIgnorePattern: '^_|^err|^ev', // _xxx, err, error, ev, event
            },
        ],

        'default-param-last': 0,
        '@typescript-eslint/default-param-last': 2,

        'no-dupe-class-members': 0,
        '@typescript-eslint/no-dupe-class-members': 2,

        // disabled rules
        '@typescript-eslint/explicit-function-return-type': 0,
        '@typescript-eslint/explicit-member-accessibility': 0,
        '@typescript-eslint/no-explicit-any': 0,
        '@typescript-eslint/no-inferrable-types': 0,
        '@typescript-eslint/no-non-null-assertion': 0,
    },
};
