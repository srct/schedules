import * as React from 'react';

interface Props {
    onSearch: (searchTerm: string) => void;
}

interface State {
    searchTerm: string;
}

export default class SearchBar extends React.Component<Props, State> {
    constructor(props: Props) {
        super(props);
        this.state = { searchTerm: '' };

        this.onSearch = this.onSearch.bind(this);
        this.updateSearchTerm = this.updateSearchTerm.bind(this);
    }

    updateSearchTerm(event: any) {
        this.setState({
            searchTerm: event.target.value,
        });
    }

    onSearch(event: any) {
        this.props.onSearch(this.state.searchTerm);
        event.preventDefault();
    }

    render() {
        return (
            <form onSubmit={this.onSearch}>
                <input
                    type="text"
                    placeholder="Enter CRN..."
                    value={this.state.searchTerm}
                    onChange={this.updateSearchTerm}
                />
                <input type="submit" value="Search" />
            </form>
        );
    }
}
